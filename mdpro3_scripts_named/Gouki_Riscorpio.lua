--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 刚鬼 闪光斧踢蝎  (ID: 60461077)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 2300 | DEF 0
-- Setcode: 252
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己场上的怪兽不存在的场合或者只有「刚鬼」怪兽的场合，这张卡可以不用解放作召唤。
-- ②：这张卡从场上送去墓地的场合才能发动。从卡组把「刚鬼 闪光斧踢蝎」以外的1张「刚鬼」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--剛鬼ライジングスコーピオ
function c60461077.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60461077,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c60461077.ntcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60461077,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,60461077)
	e2:SetCondition(c60461077.thcon)
	e2:SetTarget(c60461077.thtg)
	e2:SetOperation(c60461077.thop)
	c:RegisterEffect(e2)
end
function c60461077.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xfc)
end
function c60461077.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 or not Duel.IsExistingMatchingCard(c60461077.cfilter,tp,LOCATION_MZONE,0,1,nil))
end
function c60461077.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c60461077.thfilter(c)
	return c:IsSetCard(0xfc) and not c:IsCode(60461077) and c:IsAbleToHand()
end
function c60461077.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60461077.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60461077.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60461077.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
