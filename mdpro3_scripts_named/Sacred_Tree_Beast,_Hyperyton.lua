--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 神树兽 许珀利冬  (ID: 9349094)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Plant
-- Rank 9
-- ATK 2600 | DEF 1900
--
-- Effect Text:
-- 9星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己回合，自己把魔法·陷阱·怪兽的效果发动时，以和那个效果相同种类（怪兽·魔法·陷阱）的自己墓地1张卡为对象才能发动。把作为对象的卡在这张卡下面重叠作为超量素材。
-- ②：对方回合，魔法·陷阱·怪兽的效果发动时才能发动。和那个效果相同种类（怪兽·魔法·陷阱）的1个超量素材从这张卡取除，那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--神樹獣ハイペリュトン
function c9349094.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2)
	c:EnableReviveLimit()
	--attach overlay
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9349094,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,9349094)
	e1:SetCondition(c9349094.ovcon)
	e1:SetTarget(c9349094.ovtg)
	e1:SetOperation(c9349094.ovop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9349094,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,9349095)
	e2:SetCondition(c9349094.negcon)
	e2:SetTarget(c9349094.negtg)
	e2:SetOperation(c9349094.negop)
	c:RegisterEffect(e2)
end
function c9349094.ovcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and rp==tp
end
function c9349094.ovfilter(c,typ)
	return c:IsType(typ) and c:IsCanOverlay()
end
function c9349094.ovtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local typ=bit.band(re:GetActiveType(),TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c9349094.ovfilter(chkc,typ) end
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(c9349094.ovfilter,tp,LOCATION_GRAVE,0,1,nil,typ) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c9349094.ovfilter,tp,LOCATION_GRAVE,0,1,1,nil,typ)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c9349094.ovop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsCanOverlay() then
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c9349094.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp and Duel.IsChainNegatable(ev) and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c9349094.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local typ=bit.band(re:GetActiveType(),TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
		return c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and c:GetOverlayGroup():IsExists(Card.IsType,1,nil,typ)
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c9349094.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) then return end
	local typ=bit.band(re:GetActiveType(),TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
	local og=e:GetHandler():GetOverlayGroup():Filter(Card.IsType,nil,typ)
	if og:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local g=og:Select(tp,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		Duel.RaiseSingleEvent(c,EVENT_DETACH_MATERIAL,e,0,0,0,0)
		if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
