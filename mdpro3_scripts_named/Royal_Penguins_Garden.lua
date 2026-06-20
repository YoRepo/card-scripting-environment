--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 王家企鹅花园  (ID: 80893872)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 90
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把「王家企鹅花园」以外的1张「企鹅」卡加入手卡。
-- ②：1回合1次，自己主要阶段才能发动。从手卡以及自己场上的表侧表示怪兽之中选1只「企鹅」怪兽，那只怪兽的等级直到回合结束时下降1星。那之后，选自己1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--ロイヤル・ペンギンズ・ガーデン
function c80893872.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,80893872+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c80893872.activate)
	c:RegisterEffect(e1)
	--lv down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80893872,1))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c80893872.lvtg)
	e2:SetOperation(c80893872.lvop)
	c:RegisterEffect(e2)
end
function c80893872.thfilter(c)
	return c:IsSetCard(0x5a) and not c:IsCode(80893872) and c:IsAbleToHand()
end
function c80893872.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c80893872.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(80893872,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c80893872.lvfilter(c)
	return c:IsSetCard(0x5a) and c:IsLevelAbove(2) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND))
end
function c80893872.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80893872.lvfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c80893872.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c80893872.lvfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(80893872,2))
		local sg=g:Select(tp,1,1,nil)
		local tc=sg:GetFirst()
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.HintSelection(sg)
		else
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		e1:SetValue(-1)
		tc:RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.DiscardHand(tp,nil,1,1,REASON_DISCARD+REASON_EFFECT,nil)
	end
end
