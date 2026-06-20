--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔偶甜点·泡芙骑士  (ID: 75363626)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 1300
-- Setcode: 113
--
-- Effect Text:
-- 这张卡被对方破坏送去墓地时，这张卡回到卡组。此外，只要这张卡在场上表侧表示存在，对方不能选择「魔偶甜点·泡芙骑士」以外的名字带有「魔偶甜点」的怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・シューバリエ
function c75363626.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75363626,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c75363626.retcon)
	e1:SetTarget(c75363626.rettg)
	e1:SetOperation(c75363626.retop)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c75363626.atktg)
	c:RegisterEffect(e2)
end
function c75363626.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()==1-tp
		and e:GetHandler():IsPreviousControler(tp)
end
function c75363626.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c75363626.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c75363626.atktg(e,c)
	return c:IsFaceup() and not c:IsCode(75363626) and c:IsSetCard(0x71)
end
