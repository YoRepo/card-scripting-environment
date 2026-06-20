--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星遗物的醒存  (ID: 31706048)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己卡组上面把5张卡翻开。那之中有「机怪虫」怪兽或者「星遗物」卡的场合，选那之内的1张加入手卡，剩下的卡全部送去墓地。没有的场合，翻开的卡全部回到卡组。这张卡的发动后，直到回合结束时自己不是连接
-- 怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星遺物の醒存
function c31706048.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,31706048+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c31706048.target)
	e1:SetOperation(c31706048.activate)
	c:RegisterEffect(e1)
end
function c31706048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5)
		and Duel.GetDecktopGroup(tp,5):FilterCount(Card.IsAbleToHand,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c31706048.filter(c)
	return (c:IsSetCard(0x104) and c:IsType(TYPE_MONSTER)) or c:IsSetCard(0xfe) and c:IsAbleToHand()
end
function c31706048.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerCanDiscardDeck(tp,5) then
		Duel.ConfirmDecktop(tp,5)
		local g=Duel.GetDecktopGroup(tp,5)
		if g:GetCount()>0 then
			if g:IsExists(c31706048.filter,1,nil) then
				Duel.DisableShuffleCheck()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local sg=g:FilterSelect(tp,c31706048.filter,1,1,nil)
				Duel.SendtoHand(sg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sg)
				Duel.ShuffleHand(tp)
				g:Sub(sg)
				Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
			else
				Duel.ShuffleDeck(tp)
			end
		end
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c31706048.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c31706048.splimit(e,c)
	return not c:IsType(TYPE_LINK) and c:IsLocation(LOCATION_EXTRA)
end
