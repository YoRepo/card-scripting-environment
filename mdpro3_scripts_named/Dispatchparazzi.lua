--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 激摄特派狗仔队  (ID: 64966519)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fiend
-- ATK 100 | LINK
--
-- Effect Text:
-- 效果怪兽2只
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡以外的自己怪兽被选择作为攻击对象时才能发动。攻击对象转移为这张卡进行伤害计算。
-- ②：这张卡被和对方怪兽的战斗破坏时才能发动。那只对方怪兽破坏，自己基本分回复那个原本攻击力一半的数值。
--[[ __CARD_HEADER_END__ ]]

--激撮ディスパラッチ
function c64966519.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2)
	c:EnableReviveLimit()
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64966519,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,64966519)
	e1:SetCondition(c64966519.cbcon)
	e1:SetOperation(c64966519.cbop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64966519,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCountLimit(1,64966520)
	e2:SetTarget(c64966519.target)
	e2:SetOperation(c64966519.operation)
	c:RegisterEffect(e2)
end
function c64966519.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and bt~=e:GetHandler() and bt:IsControler(tp)
end
function c64966519.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local at=Duel.GetAttacker()
		if at:IsAttackable() and not at:IsImmuneToEffect(e) and not c:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,c)
		end
	end
end
function c64966519.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc:IsRelateToBattle() and bc:IsControler(1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,math.ceil(bc:GetBaseAttack()/2))
end
function c64966519.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() and Duel.Destroy(bc,REASON_EFFECT)>0 and bc:GetBaseAttack()>0 then
		Duel.Recover(tp,math.ceil(bc:GetBaseAttack()/2),REASON_EFFECT)
	end
end
