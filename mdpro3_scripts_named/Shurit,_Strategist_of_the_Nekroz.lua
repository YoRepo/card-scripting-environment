--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 影灵衣术士 施里特  (ID: 90307777)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 3
-- ATK 300 | DEF 1800
-- Setcode: 180
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：「影灵衣」仪式怪兽1只仪式召唤的场合，可以由这1张卡作为仪式召唤需要的等级数值的解放使用。
-- ②：这张卡被效果解放的场合才能发动。从卡组把1只战士族「影灵衣」仪式怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影霊衣の術士 シュリット
function c90307777.initial_effect(c)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c90307777.rlevel)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90307777,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,90307777)
	e2:SetCondition(c90307777.thcon)
	e2:SetTarget(c90307777.thtg)
	e2:SetOperation(c90307777.thop)
	c:RegisterEffect(e2)
end
function c90307777.rlevel(e,c)
	local lv=aux.GetCappedLevel(e:GetHandler())
	if c:IsSetCard(0xb4) then
		local clv=c:GetLevel()
		return (lv<<16)+clv
	else return lv end
end
function c90307777.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c90307777.filter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_RITUAL) and c:IsRace(RACE_WARRIOR) and c:IsAbleToHand()
end
function c90307777.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90307777.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90307777.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90307777.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
