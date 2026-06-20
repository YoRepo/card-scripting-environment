--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: No.101 寂静荣誉方舟骑士  (ID: 48739166)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 4
-- ATK 2100 | DEF 1000
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡2个超量素材取除，以对方场上1只特殊召唤的表侧攻击表示怪兽为对象才能发动。那只怪兽在这张卡下面重叠作为超量素材。
-- ②：场上的这张卡被战斗·效果破坏的场合，可以作为代替把这张卡1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--No.101 S・H・Ark Knight
function c48739166.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48739166,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,48739166)
	e1:SetCost(c48739166.cost)
	e1:SetTarget(c48739166.target)
	e1:SetOperation(c48739166.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c48739166.reptg)
	c:RegisterEffect(e2)
end
aux.xyz_number[48739166]=101
function c48739166.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c48739166.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsCanOverlay()
end
function c48739166.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c48739166.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c48739166.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	Duel.SelectTarget(tp,c48739166.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c48739166.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and tc:IsType(TYPE_MONSTER) and tc:IsCanOverlay() then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c48739166.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
