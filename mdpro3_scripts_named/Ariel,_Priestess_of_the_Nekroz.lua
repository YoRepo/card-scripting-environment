--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 影灵衣巫女 艾莉娅儿  (ID: 56827051)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Psychic
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 180
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，把手卡的「影灵衣」卡任意数量给对方观看才能发动。这张卡的等级直到回合结束时上升或下降给人观看的数量的数值。
-- ②：这张卡被效果解放的场合才能发动。从卡组把仪式怪兽以外的1只「影灵衣」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影霊衣の巫女 エリアル
function c56827051.initial_effect(c)
	--level change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56827051,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c56827051.lvcost)
	e1:SetOperation(c56827051.lvop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56827051,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCountLimit(1,56827051)
	e2:SetCondition(c56827051.thcon)
	e2:SetTarget(c56827051.thtg)
	e2:SetOperation(c56827051.thop)
	c:RegisterEffect(e2)
end
function c56827051.cfilter(c)
	return c:IsSetCard(0xb4) and not c:IsPublic()
end
function c56827051.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56827051.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c56827051.cfilter,tp,LOCATION_HAND,0,1,63,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	e:SetLabel(g:GetCount())
end
function c56827051.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local ct=e:GetLabel()
	local sel=nil
	if c:IsLevel(1) then
		sel=Duel.SelectOption(tp,aux.Stringid(56827051,2))
	else
		sel=Duel.SelectOption(tp,aux.Stringid(56827051,2),aux.Stringid(56827051,3))
	end
	if sel==1 then
		ct=ct*-1
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(ct)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c56827051.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c56827051.filter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c56827051.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56827051.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c56827051.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c56827051.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
