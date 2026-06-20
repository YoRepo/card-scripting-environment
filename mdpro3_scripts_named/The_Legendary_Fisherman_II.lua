--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 传说的渔人二世  (ID: 19801646)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 5
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- ①：这张卡的卡名只要在场上·墓地存在当作「传说的渔人」使用。
-- ②：只要场上有「海」存在，场上的这张卡不受其他怪兽的效果影响。
-- ③：表侧表示的这张卡因对方的效果从场上离开的场合或者被战斗破坏的场合才能发动。从卡组把1只水属性·7星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--伝説のフィッシャーマン二世
function c19801646.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--code
	aux.EnableChangeCode(c,3643300,LOCATION_MZONE+LOCATION_GRAVE)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c19801646.econ)
	e2:SetValue(c19801646.efilter)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(19801646,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c19801646.thcon)
	e3:SetTarget(c19801646.thtg)
	e3:SetOperation(c19801646.thop)
	c:RegisterEffect(e3)
end
function c19801646.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
function c19801646.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c19801646.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or (c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT)))
		and c:IsPreviousPosition(POS_FACEUP)
end
function c19801646.thfilter(c)
	return c:IsLevel(7) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToHand()
end
function c19801646.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19801646.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c19801646.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c19801646.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
