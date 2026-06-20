--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 龙宝龙  (ID: 11590299)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level 3
-- ATK 400 | DEF 200
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤的场合才能发动。从卡组把1只4星以下的龙族·炎属性怪兽加入手卡。
-- ②：1回合1次，自己主要阶段才能发动。自己卡组最上面的卡翻开。翻开的卡是龙族·炎属性怪兽的场合，那只怪兽送去墓地，这张卡的攻击力上升自己场上的「龙宝龙」数量×1000。不是的场合，翻开的卡回到卡组最下
-- 面。
--[[ __CARD_HEADER_END__ ]]

--ドラ・ドラ
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
function s.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsCode(id)
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_DRAGON) and tc:IsAttribute(ATTRIBUTE_FIRE) then
		Duel.DisableShuffleCheck()
		if Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)==0 or not tc:IsLocation(LOCATION_GRAVE) then return end
		local atk=Duel.GetMatchingGroupCount(s.cfilter,c:GetControler(),LOCATION_ONFIELD,0,nil)*1000
		if c:IsRelateToEffect(e) and c:IsFaceup() and atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetValue(atk)
			c:RegisterEffect(e2)
		end
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
