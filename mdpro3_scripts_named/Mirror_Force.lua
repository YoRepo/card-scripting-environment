--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 神圣防护罩 -反射镜力-  (ID: 44095762)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时才能发动。对方场上的攻击表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--聖なるバリア －ミラーフォース－
function c44095762.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c44095762.condition)
	e1:SetTarget(c44095762.target)
	e1:SetOperation(c44095762.activate)
	c:RegisterEffect(e1)
end
function c44095762.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c44095762.filter(c)
	return c:IsAttackPos()
end
function c44095762.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44095762.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c44095762.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c44095762.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44095762.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
