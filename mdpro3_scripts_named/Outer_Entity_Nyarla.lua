--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 外神 奈亚拉  (ID: 8809344)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Fiend
-- Rank 4
-- ATK 0 | DEF 2600
-- Setcode: 182
--
-- Effect Text:
-- 4星怪兽×2
-- ①：这张卡超量召唤成功时，把手卡任意数量丢弃才能发动。这张卡的阶级上升丢弃数量的数值。
-- ②：1回合1次，这张卡持有超量素材的场合以自己墓地1只怪兽为对象才能发动。这张卡的超量素材全部取除，把作为对象的怪兽在这张卡下面重叠作为超量素材。这张卡的种族·属性变成和这个效果作为超量素材的怪兽的原
-- 本的种族·属性相同。
--[[ __CARD_HEADER_END__ ]]

--外神ナイアルラ
function c8809344.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--rankup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8809344,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c8809344.rkcon)
	e1:SetCost(c8809344.rkcost)
	e1:SetOperation(c8809344.rkop)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8809344,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c8809344.condition)
	e2:SetTarget(c8809344.target)
	e2:SetOperation(c8809344.operation)
	c:RegisterEffect(e2)
end
function c8809344.rkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c8809344.rkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	local ct=Duel.DiscardHand(tp,Card.IsDiscardable,1,60,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct)
end
function c8809344.rkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_RANK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e2:SetValue(e:GetLabel())
		c:RegisterEffect(e2)
	end
end
function c8809344.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsType(TYPE_XYZ) and e:GetHandler():GetOverlayCount()>0
end
function c8809344.matfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanOverlay()
end
function c8809344.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c8809344.matfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8809344.matfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectTarget(tp,c8809344.matfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c8809344.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsCanOverlay() then
		local og=c:GetOverlayGroup()
		if og:GetCount()==0 then return end
		Duel.SendtoGrave(og,REASON_EFFECT)
		Duel.Overlay(c,Group.FromCards(tc))
		if c:IsFacedown() then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(tc:GetOriginalAttribute())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetValue(tc:GetOriginalRace())
		c:RegisterEffect(e2)
	end
end
