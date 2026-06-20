--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机甲机械骨架  (ID: 42940404)
-- Type: Monster / Effect / Union
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 54
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从卡组把「机甲机械骨架」以外的1只「机甲」怪兽加入手卡。
-- ②：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只机械族怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・ギアフレーム
function c42940404.initial_effect(c)
	aux.EnableUnionAttribute(c,c42940404.filter)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(42940404,2))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetTarget(c42940404.stg)
	e5:SetOperation(c42940404.sop)
	c:RegisterEffect(e5)
end
function c42940404.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function c42940404.sfilter(c)
	return c:IsSetCard(0x36) and not c:IsCode(42940404) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c42940404.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42940404.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c42940404.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c42940404.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
