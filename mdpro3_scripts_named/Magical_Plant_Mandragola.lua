--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔草 曼德拉草  (ID: 7802006)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 500 | DEF 200
--
-- Effect Text:
-- 反转：给场上表侧表示存在的可以放置魔力指示物的卡全部放置1个魔力指示物。
--[[ __CARD_HEADER_END__ ]]

--魔草 マンドラゴラ
function c7802006.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7802006,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c7802006.operation)
	c:RegisterEffect(e1)
end
function c7802006.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x1,1)
end
function c7802006.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c7802006.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1,1)
		tc=g:GetNext()
	end
end
