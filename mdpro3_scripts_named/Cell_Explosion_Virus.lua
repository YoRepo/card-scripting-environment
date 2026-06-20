--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 细胞爆破病毒  (ID: 84491298)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 放置有A指示物的对方怪兽的攻击宣言时才能发动。对方场上存在的攻击表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--細胞爆破ウイルス
function c84491298.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c84491298.condition)
	e1:SetTarget(c84491298.target)
	e1:SetOperation(c84491298.activate)
	c:RegisterEffect(e1)
end
function c84491298.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:GetCounter(0x100e)>0
end
function c84491298.filter(c)
	return c:IsAttackPos()
end
function c84491298.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84491298.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c84491298.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84491298.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c84491298.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
