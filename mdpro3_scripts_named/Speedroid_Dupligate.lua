--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 疾行机人复制之门  (ID: 58543073)
-- Type: Trap
-- Attribute: WIND
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 8214
--
-- Effect Text:
-- 这个卡名的②的效果在决斗中只能使用1次。
-- ①：从自己墓地把1只风属性怪兽除外，以对方场上1张卡为对象才能发动。那张卡回到持有者手卡。
-- ②：这张卡在墓地存在的场合，自己主要阶段以自己场上1只「疾行机人」怪兽为对象才能发动。那只怪兽的等级下降1星，这张卡变成通常怪兽（机械族·调整·风·1星·攻/守0）在怪兽区域特殊召唤（不当作陷阱卡使用
-- ）。
--[[ __CARD_HEADER_END__ ]]

--SRデュプリゲート
function c58543073.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58543073,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c58543073.cost)
	e1:SetTarget(c58543073.target)
	e1:SetOperation(c58543073.activate)
	c:RegisterEffect(e1)
	--substitute as a monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58543073,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,58543073+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c58543073.spcon)
	e2:SetTarget(c58543073.sptg)
	e2:SetOperation(c58543073.spop)
	c:RegisterEffect(e2)
end
function c58543073.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToRemoveAsCost()
end
function c58543073.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58543073.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c58543073.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c58543073.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c58543073.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c58543073.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or ph==PHASE_MAIN2) and Duel.GetTurnPlayer()==tp
end
function c58543073.lvfilter(c)
	return c:IsSetCard(0x2016) and c:GetLevel()>1 and c:IsFaceup()
end
function c58543073.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c58543073.lvfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,58543073,0x2016,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND)
		and Duel.IsExistingTarget(c58543073.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c58543073.lvfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c58543073.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,58543073,0x2016,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND)~=0 then
			c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TUNER)
			Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
