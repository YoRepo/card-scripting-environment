--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 星圣神龙 托勒密星团M7  (ID: 38495396)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 6
-- ATK 2700 | DEF 2000
-- Setcode: 83
--
-- Effect Text:
-- 6星怪兽×2
-- 这张卡也能在「星圣神龙 托勒密星团M7」以外的自己场上的「星圣」超量怪兽上面重叠来超量召唤。这个方法特殊召唤的回合，这张卡的①的效果不能发动。
-- ①：1回合1次，把这张卡1个超量素材取除，以自己或对方的场上·墓地1只怪兽为对象才能发动。那只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・トレミスM7
function c38495396.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2,c38495396.ovfilter,aux.Stringid(38495396,1),2,c38495396.xyzop)
	c:EnableReviveLimit()
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(38495396,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c38495396.thcost)
	e2:SetTarget(c38495396.thtg)
	e2:SetOperation(c38495396.thop)
	c:RegisterEffect(e2)
end
function c38495396.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x53) and not c:IsCode(38495396) and c:IsType(TYPE_XYZ)
end
function c38495396.xyzop(e,tp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(38495396,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END,0,1)
end
function c38495396.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c38495396.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c38495396.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and c38495396.thfilter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(38495396)==0
		and Duel.IsExistingTarget(c38495396.thfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=aux.SelectTargetFromFieldFirst(tp,c38495396.thfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c38495396.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
