--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 异次元的女战士  (ID: 7572887)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1600
--
-- Effect Text:
-- ①：这张卡和对方怪兽进行战斗的伤害计算后才能发动。那些进行战斗的各自怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--異次元の女戦士
function c7572887.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7572887,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetTarget(c7572887.target)
	e1:SetOperation(c7572887.operation)
	c:RegisterEffect(e1)
end
function c7572887.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	if chk==0 then
		return (t==c and a:IsAbleToRemove())
			or (a==c and t~=nil and t:IsAbleToRemove())
	end
	local g=Group.CreateGroup()
	if a:IsRelateToBattle() then g:AddCard(a) end
	if t~=nil and t:IsRelateToBattle() then g:AddCard(t) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c7572887.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local g=Group.FromCards(a,d)
	local rg=g:Filter(Card.IsRelateToBattle,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end
