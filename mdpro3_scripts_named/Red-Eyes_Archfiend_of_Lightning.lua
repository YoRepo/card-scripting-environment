--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 真红眼凶雷皇-邪性恶魔  (ID: 39357122)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 4522043
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●1回合1次，自己主要阶段才能发动。持有比这张卡的攻击力低的守备力的对方场上的表侧表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--真紅眼の凶雷皇－エビル・デーモン
function c39357122.initial_effect(c)
	aux.EnableDualAttribute(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c39357122.destg)
	e1:SetOperation(c39357122.desop)
	c:RegisterEffect(e1)
end
function c39357122.filter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk-1)
end
function c39357122.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=e:GetHandler():GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c39357122.filter,tp,0,LOCATION_MZONE,1,nil,atk) end
	local g=Duel.GetMatchingGroup(c39357122.filter,tp,0,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c39357122.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local atk=c:GetAttack()
	local g=Duel.GetMatchingGroup(c39357122.filter,tp,0,LOCATION_MZONE,nil,atk)
	Duel.Destroy(g,REASON_EFFECT)
end
