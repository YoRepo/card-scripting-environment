--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 异虫王子  (ID: 54860010)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level 6
-- ATK 2200 | DEF 400
-- Setcode: 62
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽的场合，可以从自己卡组把1只名字带有「异虫」的爬虫类族怪兽加入手卡。自己场上没有这张卡以外的名字带有「异虫」的爬虫类族怪兽存在的场合，结束阶段时这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ワーム・プリンス
function c54860010.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54860010,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetTarget(c54860010.thtg)
	e1:SetOperation(c54860010.thop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54860010,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c54860010.descon)
	e2:SetTarget(c54860010.destg)
	e2:SetOperation(c54860010.desop)
	c:RegisterEffect(e2)
end
function c54860010.filter(c)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
end
function c54860010.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54860010.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c54860010.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c54860010.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c54860010.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE)
end
function c54860010.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c54860010.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c54860010.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c54860010.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
