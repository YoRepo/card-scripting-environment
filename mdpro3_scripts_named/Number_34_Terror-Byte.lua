--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: No.34 电算机兽 太字节  (ID: 32003338)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Machine
-- Rank 3
-- ATK 0 | DEF 2900
-- Setcode: 72
--
-- Effect Text:
-- 3星怪兽×3
-- ①：1回合1次，把这张卡1个超量素材取除，以对方场上1只4星以下的攻击表示怪兽为对象才能发动。那只怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--No.34 電算機獣テラ・バイト
function c32003338.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,3)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(32003338,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c32003338.cost)
	e1:SetTarget(c32003338.target)
	e1:SetOperation(c32003338.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[32003338]=34
function c32003338.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c32003338.filter(c)
	return c:IsFaceup() and c:IsAttackPos() and c:IsLevelBelow(4) and c:IsControlerCanBeChanged()
end
function c32003338.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c32003338.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32003338.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c32003338.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c32003338.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
