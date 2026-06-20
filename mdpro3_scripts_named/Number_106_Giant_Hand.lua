--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: No.106 巨岩掌 巨手  (ID: 63746411)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank 4
-- ATK 2000 | DEF 2000
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- ①：对方场上的怪兽的效果发动时，把这张卡2个超量素材取除，以对方场上1只效果怪兽为对象才能发动。这只怪兽表侧表示存在期间，作为对象的效果怪兽的效果无效化，也不能作表示形式的变更。
--[[ __CARD_HEADER_END__ ]]

--No.106 巨岩掌ジャイアント・ハンド
function c63746411.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63746411,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c63746411.condition)
	e1:SetCost(c63746411.cost)
	e1:SetTarget(c63746411.target)
	e1:SetOperation(c63746411.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[63746411]=106
function c63746411.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER)
		and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE
end
function c63746411.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c63746411.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c63746411.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c63746411.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63746411.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c63746411.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c63746411.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e)
		and tc:IsType(TYPE_EFFECT) and not tc:IsImmuneToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c63746411.rcon)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		tc:RegisterEffect(e2)
	end
end
function c63746411.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
