--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 超重蒸鬼 铁道王-O  (ID: 17775525)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level 12
-- ATK 2000 | DEF 4800
-- Setcode: 154
--
-- Effect Text:
-- 「超重武者」调整＋调整以外的「超重武者」怪兽2只以上
-- 这个卡名在规则上也当作「超重武者」卡使用。
-- ①：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
-- ②：1回合1次，把最多2张手卡丢弃，以丢弃数量的对方场上的卡为对象才能发动。那些卡破坏。
-- ③：1回合1次，自己主要阶段才能发动。双方墓地的魔法·陷阱卡全部除外，给与对方除外数量×200伤害。
--[[ __CARD_HEADER_END__ ]]

--超重蒸鬼テツドウ－O
function c17775525.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x9a),aux.NonTuner(Card.IsSetCard,0x9a),2)
	c:EnableReviveLimit()
	--defense attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DEFENSE_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17775525,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c17775525.cost)
	e2:SetTarget(c17775525.target)
	e2:SetOperation(c17775525.operation)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17775525,1))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c17775525.rmtg)
	e3:SetOperation(c17775525.rmop)
	c:RegisterEffect(e3)
end
function c17775525.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	local rt=Duel.GetTargetCount(nil,tp,0,LOCATION_ONFIELD,nil)
	if rt>2 then rt=2 end
	local cg=Duel.DiscardHand(tp,Card.IsDiscardable,1,rt,REASON_COST+REASON_DISCARD,nil)
	e:SetLabel(cg)
end
function c17775525.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
end
function c17775525.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local rg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if rg:GetCount()>0 then
		Duel.Destroy(rg,REASON_EFFECT)
	end
end
function c17775525.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c17775525.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17775525.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	local g=Duel.GetMatchingGroup(c17775525.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*200)
end
function c17775525.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c17775525.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*200,REASON_EFFECT)
	end
end
