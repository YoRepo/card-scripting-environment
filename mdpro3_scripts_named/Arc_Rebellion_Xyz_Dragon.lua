--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 弧叛逆超量龙  (ID: 64276752)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Dragon
-- Rank 5
-- ATK 3000 | DEF 2500
-- Setcode: 20652147
--
-- Effect Text:
-- 5星怪兽×3
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：超量召唤的这张卡不会被效果破坏。
-- ②：把这张卡1个超量素材取除才能发动。这张卡的攻击力上升这张卡以外的场上的怪兽的原本攻击力的合计数值。这张卡有暗属性超量怪兽在作为超量素材的场合，再让这张卡以外的场上的全部表侧表示怪兽的效果无效化。这
-- 个效果的发动后，直到回合结束时自己不用这张卡不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--アーク・リベリオン・エクシーズ・ドラゴン
function c64276752.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetCondition(c64276752.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64276752,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,64276752)
	e2:SetCost(c64276752.cost)
	e2:SetTarget(c64276752.target)
	e2:SetOperation(c64276752.operation)
	c:RegisterEffect(e2)
end
function c64276752.indcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c64276752.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c64276752.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler()):GetSum(Card.GetBaseAttack)>0 end
end
function c64276752.mgfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c64276752.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c):GetSum(Card.GetBaseAttack)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			e1:SetValue(atk)
			c:RegisterEffect(e1)
			local mg=c:GetOverlayGroup()
			if mg:IsExists(c64276752.mgfilter,1,nil) then
				local g=Duel.GetMatchingGroup(aux.NegateMonsterFilter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
				for tc in aux.Next(g) do
					local e2=Effect.CreateEffect(c)
					e2:SetType(EFFECT_TYPE_SINGLE)
					e2:SetCode(EFFECT_DISABLE)
					e2:SetReset(RESET_EVENT+RESETS_STANDARD)
					tc:RegisterEffect(e2)
					local e3=Effect.CreateEffect(c)
					e3:SetType(EFFECT_TYPE_SINGLE)
					e3:SetCode(EFFECT_DISABLE_EFFECT)
					e3:SetReset(RESET_EVENT+RESETS_STANDARD)
					tc:RegisterEffect(e3)
				end
			end
		end
	end
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e0:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e0:SetTargetRange(LOCATION_MZONE,0)
	e0:SetTarget(c64276752.ftarget)
	e0:SetLabel(c:GetFieldID())
	e0:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e0,tp)
end
function c64276752.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
