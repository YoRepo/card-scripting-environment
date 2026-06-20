--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 哥布林杂耍艺人  (ID: 18658572)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 172
--
-- Effect Text:
-- 每次自己的结束阶段，自己卡组最下面的卡给双方确认，那张卡在自己卡组最上面放置或里侧表示从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--見世物ゴブリン
function c18658572.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18658572,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c18658572.cfcon)
	e2:SetOperation(c18658572.cfop)
	c:RegisterEffect(e2)
end
function c18658572.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)~=0
end
function c18658572.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then return end
	local tc=g:GetMinGroup(Card.GetSequence):GetFirst()
	Duel.MoveSequence(tc,SEQ_DECKTOP)
	Duel.ConfirmDecktop(tp,1)
	if tc:IsAbleToRemove(tp,POS_FACEDOWN) and Duel.SelectYesNo(tp,aux.Stringid(18658572,1)) then
		Duel.DisableShuffleCheck()
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end
