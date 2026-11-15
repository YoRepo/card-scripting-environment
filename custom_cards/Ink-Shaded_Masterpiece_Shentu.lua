--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Masterpiece Shentu  (ID: 99811060)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Illusion
-- Rank 10
-- ATK 2800 | DEF 2000
-- Setcode: 0x3961 (Ink-Shaded Masterpiece)
--
-- Materials: 2 Level 10 monsters
--
-- Effect Text:
-- You can also Xyz Summon this card using 1 Level 10 or higher "Ink Shader" monster you control as
-- material. You can only use each effect of "Ink-Shaded Masterpiece Shentu" once per turn.
-- ① If this card is Xyz Summoned: You can target any number of your banished "Ink-Shade" Spell/Traps
-- with different names; Set them, and if you do, destroy that many cards on the field.
-- ② During the Main Phase (Quick Effect): You can return this card to the Extra Deck, and if you do,
-- Special Summon 1 "Ink Shader" monster attached to this card.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Masterpiece Shentu
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon: 2 Level 10 monsters, or 1 Level 10 or higher "Ink Shader" monster you control
	aux.AddXyzProcedure(c,nil,10,2,s.ovfilter,aux.Stringid(id,0))
	c:EnableReviveLimit()
	--(1) if this card is Xyz Summoned: target any number of your banished "Ink-Shade" Spells/Traps with different
	--names; Set them, and if you do, destroy that many cards on the field (cf. Divine Serpent Apophis)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_SSET+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.setcon)
	e1:SetTarget(s.settg)
	e1:SetOperation(s.setop)
	c:RegisterEffect(e1)
	--(2) (Quick Effect) during the Main Phase: return this card to the Extra Deck, and if you do, Special Summon
	--1 "Ink Shader" monster that was attached to it (cf. Elfnote June Pride)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,2))
	e2:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
--alternative Xyz material: 1 Level 10 or higher "Ink Shader" monster you control
function s.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevelAbove(10)
end
--(1)
function s.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.setfilter(c,e)
	return c:IsFaceup() and c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
		and c:IsCanBeEffectTarget(e)
end
--different names; a Field Spell goes to the Field Zone, the rest need a free Spell & Trap Zone each
function s.setcheck(g,ft)
	local fct=g:FilterCount(Card.IsType,nil,TYPE_FIELD)
	return aux.dncheck(g) and fct<=1 and #g-fct<=ft
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and s.setfilter(chkc,e) end
	local g=Duel.GetMatchingGroup(s.setfilter,tp,LOCATION_REMOVED,0,nil,e)
	if chk==0 then return #g>0 end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local sg=g:SelectSubGroup(tp,s.setcheck,false,1,#g,ft)
	if not sg then return end
	Duel.SetTargetCard(sg)
	local dg=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,#sg,0,0)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetsRelateToChain()
	if #tg==0 then return end
	--if fewer zones remain than when the targets were chosen, choose which of them to Set
	local fg=tg:Filter(Card.IsType,nil,TYPE_FIELD)
	tg:Sub(fg)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then
		tg:Clear()
	elseif #tg>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		tg=tg:Select(tp,ft,ft,nil)
	end
	tg:Merge(fg)
	if #tg==0 then return end
	local ct=Duel.SSet(tp,tg)
	if ct==0 then return end
	--"that many": exactly as many cards as were Set, from either field
	local dg=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if #dg<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=dg:Select(tp,ct,ct,nil)
	Duel.HintSelection(sg)
	Duel.Destroy(sg,REASON_EFFECT)
end
--(2)
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase()
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x960) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtra() and Duel.GetMZoneCount(tp,c)>0
		and c:GetOverlayGroup():IsExists(s.spfilter,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_OVERLAY)
end
--a material cannot be Special Summoned straight from under an Xyz Monster, and this card's materials go to the GY
--the moment it leaves the field: so remember what was attached, return this card, then Special Summon one of
--those monsters from where the game put it (cf. Xyz Encore, Xyz Force: "from your GY or your banishment")
function s.spfilter2(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and c:IsFaceupEx() and s.spfilter(c,e,tp)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	local og=c:GetOverlayGroup()
	if Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)==0 or not c:IsLocation(LOCATION_EXTRA) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=og:Filter(aux.NecroValleyFilter(s.spfilter2),nil,e,tp)
	if #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,1,1,nil)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
