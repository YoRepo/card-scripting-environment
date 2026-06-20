--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: G石人·威严三巨石  (ID: 50546029)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Cyberse
-- ATK 3200 | LINK
-- Setcode: 390
--
-- Effect Text:
-- 地属性怪兽2只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：可以攻击的对方怪兽必须向这张卡作出攻击。
-- ②：这张卡和对方怪兽进行战斗的伤害计算前1次，从手卡把1只地属性怪兽送去墓地才能发动。那只对方怪兽直到回合结束时攻击力下降200，效果无效化。
-- ③：自己场上的连接怪兽为对象的效果由对方发动时才能发动。那个效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--Gゴーレム・ディグニファイド・トリリトン
function c50546029.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkAttribute,ATTRIBUTE_EARTH),2)
	c:EnableReviveLimit()
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e2:SetValue(c50546029.atklimit)
	c:RegisterEffect(e2)
	--atk down/disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(50546029,0))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c50546029.atkcon)
	e3:SetCost(c50546029.atkcost)
	e3:SetOperation(c50546029.atkop)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(50546029,1))
	e4:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,50546029)
	e4:SetCondition(c50546029.discon)
	e4:SetTarget(c50546029.distg)
	e4:SetOperation(c50546029.disop)
	c:RegisterEffect(e4)
end
function c50546029.atklimit(e,c)
	return c==e:GetHandler()
end
function c50546029.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsRelateToBattle() and bc:IsControler(1-tp)
end
function c50546029.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsAbleToGraveAsCost()
end
function c50546029.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50546029.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c50546029.cfilter,1,1,REASON_COST)
end
function c50546029.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsFaceup() and bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.NegateRelatedChain(bc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		bc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e3:SetValue(RESET_TURN_SET)
		bc:RegisterEffect(e3)
	end
end
function c50546029.acfilter(c,tp)
	return c:IsType(TYPE_LINK) and c:IsControler(tp) and c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
end
function c50546029.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return rp==1-tp and tg and tg:IsExists(c50546029.acfilter,1,nil,tp)
end
function c50546029.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c50546029.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
