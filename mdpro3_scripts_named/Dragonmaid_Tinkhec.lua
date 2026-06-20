--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 半龙女仆·赤焰龙女  (ID: 42055234)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level 8
-- ATK 2700 | DEF 1700
-- Setcode: 307
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己·对方回合，把这张卡从手卡丢弃，以自己场上1只「半龙女仆」怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升2000。
-- ②：只要自己场上有融合怪兽存在，这张卡不会被效果破坏。
-- ③：自己·对方的战斗阶段结束时才能发动。这张卡回到手卡，从手卡把1只3星「半龙女仆」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンメイド・フランメ
function c42055234.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42055234,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,42055234)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c42055234.atkcost)
	e1:SetTarget(c42055234.atktg)
	e1:SetOperation(c42055234.atkop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c42055234.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(42055234,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,42055235)
	e3:SetTarget(c42055234.sptg)
	e3:SetOperation(c42055234.spop)
	c:RegisterEffect(e3)
end
function c42055234.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c42055234.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x133)
end
function c42055234.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c42055234.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42055234.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c42055234.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c42055234.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c42055234.indfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c42055234.indcon(e)
	return Duel.IsExistingMatchingCard(c42055234.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c42055234.spfilter(c,e,tp)
	return c:IsSetCard(0x133) and c:IsLevel(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c42055234.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c42055234.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c42055234.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoHand(c,nil,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_HAND) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c42055234.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
