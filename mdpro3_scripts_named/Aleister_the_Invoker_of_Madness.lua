--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 暴走召唤师 阿莱斯特  (ID: 97973962)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Spellcaster
-- ATK 1800 | LINK
-- Setcode: 481
--
-- Effect Text:
-- 种族和属性不同的怪兽2只
-- ①：这张卡的卡名只要在场上·墓地存在当作「召唤师 阿莱斯特」使用。
-- ②：这张卡在怪兽区域存在的状态，融合怪兽融合召唤的场合才能发动。选自己1张手卡丢弃，从卡组把1张「召唤魔术」或「法之圣典」加入手卡。
-- ③：表侧表示的这张卡因对方的效果从场上离开的场合才能发动。从卡组把1张「魔法名-「大兽」」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--暴走召喚師アレイスター
function c97973962.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddCodeList(c,74063034,458748,47457347)
	aux.AddLinkProcedure(c,nil,2,2,c97973962.spcheck)
	--code
	aux.EnableChangeCode(c,86120751,LOCATION_MZONE+LOCATION_GRAVE)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97973962,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c97973962.thcon)
	e2:SetTarget(c97973962.thtg)
	e2:SetOperation(c97973962.thop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(97973962,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c97973962.thcon2)
	e3:SetTarget(c97973962.thtg2)
	e3:SetOperation(c97973962.thop2)
	c:RegisterEffect(e3)
end
function c97973962.spcheck(g)
	return g:GetClassCount(Card.GetLinkRace)==g:GetCount() and g:GetClassCount(Card.GetLinkAttribute)==g:GetCount()
end
function c97973962.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonType,1,nil,SUMMON_TYPE_FUSION)
end
function c97973962.thfilter(c)
	return c:IsCode(74063034,458748) and c:IsAbleToHand()
end
function c97973962.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
		and Duel.IsExistingMatchingCard(c97973962.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c97973962.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c97973962.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c97973962.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT))	and c:IsPreviousPosition(POS_FACEUP)
end
function c97973962.thfilter2(c)
	return c:IsCode(47457347) and c:IsAbleToHand()
end
function c97973962.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97973962.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c97973962.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c97973962.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
