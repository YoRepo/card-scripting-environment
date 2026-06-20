--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电子暗黑世界  (ID: 64753988)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 16531
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这个卡名的②的效果1回合只能使用1次。
-- ①：作为这张卡的发动时的效果处理，可以把同名卡不在自己墓地存在的1只「电子暗黑」怪兽从卡组加入手卡。
-- ②：自己主要阶段才能发动。进行1只「电子暗黑」怪兽的召唤。
-- ③：「电子暗黑」怪兽的召唤·特殊召唤成功时发动的自身的效果让自己从自己墓地把怪兽装备的场合，也能作为代替从对方墓地装备。
--[[ __CARD_HEADER_END__ ]]

--サイバーダーク・ワールド
function c64753988.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,64753988+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c64753988.activate)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64753988,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,64753989)
	e2:SetTarget(c64753988.sumtg)
	e2:SetOperation(c64753988.sumop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(64753988)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,0)
	c:RegisterEffect(e3)
end
function c64753988.filter(c,tp)
	return c:IsSetCard(0x4093) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,c:GetCode())
end
function c64753988.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c64753988.filter,tp,LOCATION_DECK,0,nil,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(64753988,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c64753988.sumfilter(c)
	return c:IsSetCard(0x4093) and c:IsSummonable(true,nil)
end
function c64753988.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64753988.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c64753988.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c64753988.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
