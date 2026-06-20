--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 异响鸣的倒水  (ID: 42193638)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 419
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从以下效果选1个适用。自己的灵摆区域没有「异响鸣」卡存在的场合，适用的效果由对方来选。
-- ●自己回复500基本分。那之后，可以直到「异响鸣」卡出现为止从自己卡组上面翻卡。那个场合，翻开的「异响鸣」卡加入手卡，剩余回到卡组。
-- ●自己受到500伤害。那之后，可以从卡组把「异响鸣的倒水」以外的1张「异响鸣」卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカ・ヴェルサーレ
local s,id,o=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DAMAGE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsSetCard(0x1a3) and c:IsAbleToGrave() and not c:IsCode(id)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp,op)
	if op==nil then
		local p=Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,nil,0x1a3) and tp or 1-tp
		op=aux.SelectFromOptions(p,{true,aux.Stringid(id,1)},{true,aux.Stringid(id,2)})
	end
	if op==1 then
		if Duel.Recover(tp,500,REASON_EFFECT)<1
			or not Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil)
			or not Duel.SelectYesNo(tp,aux.Stringid(id,3)) then return end
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x1a3)
		local dct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
		local seq=-1
		local hc
		for tc in aux.Next(g) do
			local sq=tc:GetSequence()
			if sq>seq then
				seq=sq
				hc=tc
			end
		end
		Duel.BreakEffect()
		if seq>-1 then
			Duel.ConfirmDecktop(tp,dct-seq)
			Duel.DisableShuffleCheck()
			if hc:IsAbleToHand() then
				Duel.SendtoHand(hc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,hc)
				Duel.ShuffleHand(tp)
			else
				Duel.SendtoGrave(hc,REASON_RULE)
			end
		else
			Duel.ConfirmDecktop(tp,dct)
		end
		if dct-seq>1 then Duel.ShuffleDeck(tp) end
	elseif Duel.Damage(tp,500,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,0,nil)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,4)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg=g:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end
