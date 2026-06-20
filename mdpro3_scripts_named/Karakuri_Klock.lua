--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 时限机巧爆弹  (ID: 79178930)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 17
--
-- Effect Text:
-- 表侧守备表示存在的名字带有「机巧」的怪兽被选择作为攻击对象时才能发动。对方场上表侧表示存在的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--時限カラクリ爆弾
function c79178930.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c79178930.condition)
	e1:SetTarget(c79178930.target)
	e1:SetOperation(c79178930.activate)
	c:RegisterEffect(e1)
end
function c79178930.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsFaceup() and tc:IsDefensePos() and tc:IsSetCard(0x11)
end
function c79178930.filter(c)
	return c:IsFaceup()
end
function c79178930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79178930.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c79178930.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c79178930.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c79178930.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
