--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Raidraptor - Strangle Lanius  (ID: 87321742)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 4
-- ATK 1600 | DEF 1100
-- Setcode: 0xba
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a DARK monster: You can Special Summon this card from your hand, also you cannot
-- Special Summon monsters for the rest of this turn, except DARK monsters.
-- If you control an Xyz Monster with a DARK Xyz Monster as material: You can target 1 Level 4 or lower
-- "Raidraptor" monster in your GY; Special Summon it, but its effects are negated.
-- You can only use each effect of "Raidraptor - Strangle Lanius" once per turn.
--[[ __CARD_HEADER_END__ ]]

--RR－ストラングル・レイニアス
function c87321742.initial_effect(c)
	--self ss
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87321742,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,87321742)
	e1:SetCondition(c87321742.sscon)
	e1:SetTarget(c87321742.sstg)
	e1:SetOperation(c87321742.ssop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87321742,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,87321743)
	e2:SetCondition(c87321742.spcon)
	e2:SetTarget(c87321742.sptg)
	e2:SetOperation(c87321742.spop)
	c:RegisterEffect(e2)
end
function c87321742.ssfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsFaceup()
end
function c87321742.sscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c87321742.ssfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c87321742.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c87321742.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c87321742.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c87321742.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_DARK)
end
function c87321742.tgfilter(c,e,tp)
	return c:IsSetCard(0xba) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87321742.mfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c87321742.ffilter(c)
	return c:IsType(TYPE_XYZ) and c:GetOverlayGroup():IsExists(c87321742.mfilter,1,nil) and c:IsFaceup()
end
function c87321742.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c87321742.ffilter,tp,LOCATION_MZONE,0,1,nil)
end
function c87321742.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c87321742.tgfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c87321742.tgfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c87321742.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c87321742.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
