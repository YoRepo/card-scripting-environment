--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 混沌No.39 希望皇 霍普雷  (ID: 56840427)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 4
-- ATK 2500 | DEF 2000
-- Setcode: 276762696
--
-- Effect Text:
-- 光属性4星怪兽×3
-- 这张卡也能在自己场上的「No.39 希望皇 霍普」上面重叠来超量召唤。
-- ①：把这张卡1个超量素材取除才能发动。直到回合结束时这张卡的攻击力上升500，选对方场上1只怪兽那个攻击力直到回合结束时下降1000。这个效果在自己基本分是1000以下的场合才能发动和处理。
--[[ __CARD_HEADER_END__ ]]

--CNo.39 希望皇ホープレイ
function c56840427.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),4,3,c56840427.ovfilter,aux.Stringid(56840427,1))
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(56840427,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c56840427.condition)
	e1:SetCost(c56840427.cost)
	e1:SetOperation(c56840427.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[56840427]=39
function c56840427.ovfilter(c)
	return c:IsFaceup() and c:IsCode(84013237)
end
function c56840427.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000
end
function c56840427.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c56840427.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)>1000 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(-1000)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			g:GetFirst():RegisterEffect(e2)
		end
	end
end
