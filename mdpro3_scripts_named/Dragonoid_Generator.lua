--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 机龙生成器  (ID: 28053763)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 支付1000基本分才能把这张卡发动。这个卡名的①的效果1回合可以使用最多2次。
-- ①：自己主要阶段才能发动。把1只「机龙衍生物」（机械族·地·1星·攻/守300）在自己场上攻击表示特殊召唤。这个效果的发动后，直到回合结束时自己不能从额外卡组把怪兽特殊召唤。这个回合的结束阶段，对方必
-- 须把1只「机龙衍生物」在自身场上攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラゴノイド・ジェネレーター
function c28053763.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c28053763.cost)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28053763,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(2,28053763)
	e2:SetTarget(c28053763.tktg)
	e2:SetOperation(c28053763.tkop)
	c:RegisterEffect(e2)
end
function c28053763.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c28053763.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,28053764,0,TYPES_TOKEN_MONSTER,300,300,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c28053763.tkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLocation,LOCATION_EXTRA))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,28053764,0,TYPES_TOKEN_MONSTER,300,300,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) then return end
	local token=Duel.CreateToken(tp,28053764)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28053763,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetOperation(c28053763.tkop2)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c28053763.tkop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(1-tp,28053764,0,TYPES_TOKEN_MONSTER,300,300,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) then return end
	Duel.Hint(HINT_CARD,0,28053763)
	local token=Duel.CreateToken(1-tp,28053764)
	Duel.SpecialSummon(token,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
end
