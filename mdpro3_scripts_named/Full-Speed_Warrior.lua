--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 最高速战士  (ID: 17201951)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 2
-- ATK 900 | DEF 400
-- Setcode: 102
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。把1只「废品同调士」或者1张有「废品战士」的卡名记述的魔法·陷阱卡从卡组加入手卡。
-- ②：只要这张卡在怪兽区域存在，自己场上的以下怪兽的攻击力只在自己战斗阶段内上升900。
-- ●有「废品战士」的卡名记述的怪兽
-- ●原本卡名包含「战士」的同调怪兽
--[[ __CARD_HEADER_END__ ]]

--フルスピード・ウォリアー
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,63977008,60800381)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCondition(s.atkcon)
	e3:SetTarget(s.atktg)
	e3:SetValue(900)
	c:RegisterEffect(e3)
end
function s.thfilter(c)
	return (aux.IsCodeListed(c,60800381) and c:IsType(TYPE_SPELL+TYPE_TRAP) or c:IsCode(63977008)) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function s.atktg(e,c)
	return aux.IsCodeListed(c,60800381) or c:IsOriginalSetCard(0x66) and c:IsType(TYPE_SYNCHRO)
end
