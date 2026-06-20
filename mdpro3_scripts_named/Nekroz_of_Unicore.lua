--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 尤尼科之影灵衣  (ID: 89463537)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 2300 | DEF 1000
-- Setcode: 180
--
-- Effect Text:
-- 「影灵衣」仪式魔法卡降临
-- 这张卡不用仪式召唤不能特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃，以「尤尼科之影灵衣」以外的自己墓地1张「影灵衣」卡为对象才能发动。那张卡加入手卡。
-- ②：只要这张卡在怪兽区域存在，从额外卡组特殊召唤的表侧表示怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ユニコールの影霊衣
function c89463537.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(89463537,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,89463537)
	e2:SetCost(c89463537.cost)
	e2:SetTarget(c89463537.target)
	e2:SetOperation(c89463537.operation)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c89463537.distg)
	c:RegisterEffect(e3)
end
function c89463537.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c89463537.filter(c)
	return c:IsSetCard(0xb4) and not c:IsCode(89463537) and c:IsAbleToHand()
end
function c89463537.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c89463537.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89463537.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c89463537.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c89463537.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c89463537.distg(e,c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
