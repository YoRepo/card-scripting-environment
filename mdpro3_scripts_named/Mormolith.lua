--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 摩门  (ID: 71717923)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1000 | DEF 900
--
-- Effect Text:
-- 把自己场上表侧表示存在的1只地属性怪兽解放发动。场上表侧表示存在持有解放怪兽的攻击力以下的守备力的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--モーム
function c71717923.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71717923,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c71717923.descost)
	e1:SetTarget(c71717923.destg)
	e1:SetOperation(c71717923.desop)
	c:RegisterEffect(e1)
end
function c71717923.costfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH)
		and Duel.IsExistingMatchingCard(c71717923.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetAttack())
end
function c71717923.filter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk)
end
function c71717923.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c71717923.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c71717923.costfilter,1,1,nil)
	e:SetLabel(g:GetFirst():GetAttack())
	Duel.Release(g,REASON_COST)
end
function c71717923.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c71717923.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c71717923.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c71717923.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	Duel.Destroy(g,REASON_EFFECT)
end
