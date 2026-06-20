--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 重起士道-金骑士  (ID: 72305034)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡召唤·特殊召唤成功的场合才能发动。效果文本有「二重怪兽」记述的1张魔法·陷阱卡从卡组加入手卡。这个卡名的这个效果1回合只能使用1次。
-- ●这张卡变成机械族，攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--重起士道－ゴルドナイト
function c72305034.initial_effect(c)
	aux.EnableDualAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72305034,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,72305034)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c72305034.thtg)
	e1:SetOperation(c72305034.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--change race
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_RACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(aux.IsDualState)
	e3:SetValue(RACE_MACHINE)
	c:RegisterEffect(e3)
	--atkup
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(500)
	c:RegisterEffect(e4)
end
function c72305034.thfilter(c)
	return aux.IsTypeInText(c,TYPE_DUAL) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c72305034.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72305034.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c72305034.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c72305034.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
