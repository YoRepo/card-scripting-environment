--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恐啡肽狂龙甲壳  (ID: 25419323)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 371
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方战斗阶段开始时，把基本分支付一半才能发动。在自己场上把1只「恐啡肽狂龙衍生物」（恐龙族·暗·10星·攻0/守3000）特殊召唤。这个回合，只要这个效果特殊召唤的衍生物在自己场上存在，对方不能选
-- 择其他怪兽作为攻击对象。
-- ②：自己基本分是2000以下，自己要受到战斗伤害的伤害计算时，把墓地的这张卡除外才能发动。那次战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--ダイノルフィア・シェル
function c25419323.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCountLimit(1,25419323+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c25419323.condition)
	e1:SetCost(c25419323.cost)
	e1:SetTarget(c25419323.target)
	e1:SetOperation(c25419323.operation)
	c:RegisterEffect(e1)
	--negate damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c25419323.damcon)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c25419323.damop)
	c:RegisterEffect(e2)
end
function c25419323.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_START and Duel.GetTurnPlayer()==1-tp
end
function c25419323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c25419323.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,25419324,0,TYPES_TOKEN_MONSTER,0,3000,10,RACE_DINOSAUR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c25419323.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,25419324,0,TYPES_TOKEN_MONSTER,0,3000,10,RACE_DINOSAUR,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,25419324)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c25419323.atklimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	token:RegisterEffect(e1)
end
function c25419323.atklimit(e,c)
	return c~=e:GetHandler()
end
function c25419323.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=2000 and Duel.GetBattleDamage(tp)>0
end
function c25419323.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
