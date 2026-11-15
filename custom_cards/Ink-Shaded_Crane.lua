--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Crane  (ID: 99811030)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Illusion
-- Level 6
-- ATK 1900 | DEF 1700
-- Setcode: 0x1961 (Ink-Shaded)
--
-- Materials: 1 "Ink Shader" monster + 1 WATER monster
--
-- Effect Text:
-- Must either be Fusion Summoned, or Special Summoned (from your Extra Deck) by sending 1 Spell/Trap
-- from the field to the GY while you control a Level 6 or higher "Ink Shader" monster. You can only
-- Special Summon "Ink-Shaded Crane(s)" once per turn.
-- ① If an "Ink-Shade" card is banished: You can target 1 card on the field; destroy it.
-- ② If this card is in your GY (Quick Effect): You can return this card to the Extra Deck, then target
-- 1 "Ink Shader" monster in your GY; Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Crane
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--you can only Special Summon "Ink-Shaded Crane(s)" once per turn (any method: no "this way")
	c:SetSPSummonOnce(id)
	--fusion material: 1 "Ink Shader" monster + 1 WATER monster
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x960),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WATER),true)
	--must be Fusion Summoned, or Special Summoned by the procedure below, which the engine does not check
	--against this (cf. Artmage Non-Finito, Divine Serpent Apophis)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.fuslimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): send 1 Spell/Trap from the field to the GY while you control a Level 6+ "Ink Shader" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) if an "Ink-Shade" card is banished: target 1 card on the field; destroy it (cf. Bujin Arasuda)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
	--(2) (Quick Effect) from GY: return this card to the Extra Deck, then target 1 "Ink Shader" monster in your GY; Special Summon it
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCost(s.rvcost)
	e3:SetTarget(s.rvtg)
	e3:SetOperation(s.rvop)
	c:RegisterEffect(e3)
end
--SS proc (send 1 Spell/Trap from the field to the GY while you control a Level 6+ "Ink Shader" monster)
function s.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevelAbove(6)
end
--"from the field": either player's, face-up or Set (cf. Trap Eater, which sends an opponent's Trap).
--A Monster Card treated as a Continuous Spell counts; one that would be banished instead cannot be sent as cost
function s.spcfilter(c,tp,sc)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
		and Duel.GetLocationCountFromEx(tp,tp,c,sc)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.lvfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,tp,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_SPSUMMON)
end
--(1)
--an "Ink-Shade" card of either player; a card banished face-down has no name
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x961)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--(2)
function s.rvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function s.rvfilter(c,e,tp)
	return c:IsSetCard(0x960) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.rvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.rvfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.rvfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,s.rvfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.rvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and aux.NecroValleyFilter()(tc) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
