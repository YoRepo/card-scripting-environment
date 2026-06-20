--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 灵子能固定装置  (ID: 99173029)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，灵魂怪兽持续留在场上。自己的结束阶段时丢弃1张手卡，若不丢弃，这张卡破坏。并且，这张卡从场上离开时，在场上存在的表侧表示的灵魂怪兽全部回到持有者的手卡。
--[[ __CARD_HEADER_END__ ]]

--霊子エネルギー固定装置
function c99173029.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spirit do not return
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPIRIT_DONOT_RETURN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e2)
	--leave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c99173029.levop)
	c:RegisterEffect(e3)
	--maintain
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c99173029.mtcon)
	e4:SetOperation(c99173029.mtop)
	c:RegisterEffect(e4)
end
c99173029.has_text_type=TYPE_SPIRIT
function c99173029.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPIRIT)
end
function c99173029.levop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c99173029.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c99173029.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c99173029.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 and Duel.SelectYesNo(tp,aux.Stringid(99173029,0)) then
		Duel.DiscardHand(tp,nil,1,1,REASON_COST+REASON_DISCARD)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
