--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 毛绒动物·狗  (ID: 39246582)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 4
-- ATK 1700 | DEF 1000
-- Setcode: 169
--
-- Effect Text:
-- 「毛绒动物·狗」的效果1回合只能使用1次。
-- ①：这张卡从手卡的召唤·特殊召唤成功时才能发动。从卡组把1只「锋利小鬼·剪刀」或者1只「毛绒动物·狗」以外的「毛绒动物」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ドッグ
function c39246582.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39246582,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,39246582)
	e1:SetCondition(c39246582.thcon)
	e1:SetTarget(c39246582.thtg)
	e1:SetOperation(c39246582.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c39246582.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c39246582.filter(c)
	return (c:IsCode(30068120) or (c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and not c:IsCode(39246582)))
		and c:IsAbleToHand()
end
function c39246582.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39246582.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c39246582.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c39246582.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
