--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 格式弹涂鱼  (ID: 50366775)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。额外卡组1只连接怪兽给对方观看。这个回合连接召唤的场合，这张卡可以当作和给人观看的怪兽相同的卡名·种族·属性的素材使用。
-- ②：这张卡作为连接素材送去墓地的场合才能发动。从卡组把1只5星以上的电子界族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--フォーマッド・スキッパー
function c50366775.initial_effect(c)
	--link
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50366775,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,50366775)
	e1:SetTarget(c50366775.target)
	e1:SetOperation(c50366775.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,50366776)
	e2:SetCondition(c50366775.thcon)
	e2:SetTarget(c50366775.thtg)
	e2:SetOperation(c50366775.thop)
	c:RegisterEffect(e2)
end
function c50366775.cfilter(c,tc)
	return c:IsType(TYPE_LINK) and not c:IsCode(tc:GetLinkCode())
end
function c50366775.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50366775.cfilter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
end
function c50366775.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c50366775.cfilter,tp,LOCATION_EXTRA,0,1,1,nil,c)
	if cg:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,cg)
	local code1,code2=cg:GetFirst():GetOriginalCodeRule()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_LINK_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(code1)
	c:RegisterEffect(e1)
	if code2 then
		local e2=e1:Clone()
		e2:SetValue(code2)
		c:RegisterEffect(e2)
	end
	local e3=e1:Clone()
	e3:SetCode(EFFECT_ADD_LINK_ATTRIBUTE)
	e3:SetValue(cg:GetFirst():GetOriginalAttribute())
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_ADD_LINK_RACE)
	e4:SetValue(cg:GetFirst():GetOriginalRace())
	c:RegisterEffect(e4)
end
function c50366775.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_LINK
end
function c50366775.thfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsLevelAbove(5) and c:IsAbleToHand()
end
function c50366775.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50366775.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c50366775.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c50366775.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
