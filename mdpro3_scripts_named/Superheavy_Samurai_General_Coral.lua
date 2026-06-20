--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 超重辉将 珊瑚-5  (ID: 78274190)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- Pendulum Scales: L8 / R8
-- ATK 300 | DEF 500
-- Setcode: 154
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：自己墓地有魔法·陷阱卡存在的场合，这张卡的灵摆刻度变成4。
-- ②：1回合1次，自己的「超重武者」怪兽战斗破坏对方怪兽时才能发动。那只怪兽只再1次可以继续攻击。
-- 【怪兽效果】
-- 这张卡在规则上也当作「超重武者」卡使用。「超重辉将 珊瑚-5」的怪兽效果1回合只能使用1次。
-- ①：自己墓地没有魔法·陷阱卡存在的场合，把自己场上最多2只「超重武者」怪兽解放才能发动。自己从卡组抽出解放的数量。
--[[ __CARD_HEADER_END__ ]]

--超重輝将サン－5
function c78274190.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_LSCALE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c78274190.sccon)
	e2:SetValue(4)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e3)
	--chain attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(78274190,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c78274190.catg)
	e4:SetOperation(c78274190.caop)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(78274190,1))
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,78274190)
	e5:SetCondition(c78274190.condition)
	e5:SetCost(c78274190.cost)
	e5:SetTarget(c78274190.target)
	e5:SetOperation(c78274190.operation)
	c:RegisterEffect(e5)
end
function c78274190.sccon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c78274190.afilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0x9a) and c:IsChainAttackable()
end
function c78274190.catg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c78274190.afilter,1,nil,tp) end
	local a=eg:Filter(c78274190.afilter,nil,tp):GetFirst()
	Duel.SetTargetCard(a)
end
function c78274190.caop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToBattle() then
		Duel.ChainAttack()
	end
end
function c78274190.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c78274190.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x9a) end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct>2 then ct=2 end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,ct,nil,0x9a)
	local rct=Duel.Release(g,REASON_COST)
	e:SetLabel(rct)
end
function c78274190.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c78274190.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
end
