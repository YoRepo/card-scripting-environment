--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 妮穆蕾莉娅的梦守卫-小枕头  (ID: 17550376)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 10
-- ATK 2500 | DEF 2000
-- Setcode: 401
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己的额外卡组有表侧表示的灵摆怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：自己的额外卡组有表侧表示的「梦见之妮穆蕾莉娅」存在的场合，从额外卡组把1张里侧表示的卡里侧表示除外才能发动。这张卡的攻击力直到回合结束时上升对方场上的怪兽数量×500。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ネムレリアの夢守り－オレイエ
function c17550376.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,17550376+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c17550376.sprcon)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17550376,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE+TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1,17550377)
	e2:SetCondition(c17550376.atkcon)
	e2:SetCost(c17550376.atkcost)
	e2:SetOperation(c17550376.atkop)
	c:RegisterEffect(e2)
end
function c17550376.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsType),tp,LOCATION_EXTRA,0,1,nil,TYPE_PENDULUM)
end
function c17550376.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.dscon(e,tp,eg,ep,ev,re,r,rp) and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsCode),tp,LOCATION_EXTRA,0,1,nil,70155677)
end
function c17550376.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToRemoveAsCost(POS_FACEDOWN)
end
function c17550376.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c17550376.rmfilter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return #g>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:Select(tp,1,1,nil)
	Duel.Remove(rg,POS_FACEDOWN,REASON_COST)
end
function c17550376.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if c:IsFaceup() and c:IsRelateToEffect(e) and ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
