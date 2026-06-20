--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 书灵师崛起  (ID: 18890039)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 380
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以把同名卡不在自己场上存在的1只「书灵师」怪兽从卡组加入手卡。
-- ②：自己主要阶段才能发动。等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「书灵师」仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--リブロマンサー・ライジング
local s,id,o=GetID()
function s.initial_effect(c)
	--add from deck to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	--Ritual sum
	local e2=aux.AddRitualProcGreater2(c,s.ritfilter,LOCATION_HAND,nil,nil,true)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	c:RegisterEffect(e2)
end
function s.ritfilter(c)
	return c:IsSetCard(0x17c)
end
function s.d2hmatchfilter(c,cd)
	return c:IsFaceup() and c:IsCode(cd)
end
function s.d2hfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x17c) and c:IsAbleToHand()
		and not Duel.IsExistingMatchingCard(s.d2hmatchfilter,tp,LOCATION_ONFIELD,0,1,nil,c:GetCode())
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.d2hfilter,tp,LOCATION_DECK,0,nil,tp)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		if #sg>0 then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
