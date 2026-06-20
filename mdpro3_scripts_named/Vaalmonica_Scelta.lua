--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 异响鸣的选择  (ID: 5605529)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 419
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从以下效果选1个适用。自己的灵摆区域没有「异响鸣」卡存在的场合，适用的效果由对方来选。
-- ●自己回复500基本分。那之后，可以选自己1张手卡回到卡组最下面。那个场合，自己抽2张。
-- ●自己受到500伤害。那之后，可以从卡组把「异响鸣的选择」以外的1张「异响鸣」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカ・シェルタ
local s,id,o=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_TODECK+CATEGORY_DRAW+CATEGORY_DAMAGE+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsSetCard(0x1a3) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand() and not c:IsCode(id)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp,op)
	if op==nil then
		local p=Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,nil,0x1a3) and tp or 1-tp
		op=aux.SelectFromOptions(p,{true,aux.Stringid(id,1)},{true,aux.Stringid(id,2)})
	end
	if op==1 then
		if Duel.Recover(tp,500,REASON_EFFECT)<1 then return end
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
		if #g>0 and Duel.IsPlayerCanDraw(tp,2) and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local sg=g:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			Duel.BreakEffect()
			Duel.SendtoDeck(sg,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
			if sg:GetFirst():IsLocation(LOCATION_DECK) then
				Duel.Draw(tp,2,REASON_EFFECT)
			end
		end
	elseif Duel.Damage(tp,500,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,0,nil)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,4)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
