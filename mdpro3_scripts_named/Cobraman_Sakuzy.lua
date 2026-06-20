--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 半蛇人 萨库兹  (ID: 75109441)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level 3
-- ATK 800 | DEF 1400
--
-- Effect Text:
-- 这张卡1回合只有1次可以变成里侧守备表示。这张卡反转时，对方场上盖放的魔法·陷阱卡全部翻开，确认后回复原状。
--[[ __CARD_HEADER_END__ ]]

--半蛇人サクズィー
function c75109441.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75109441,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c75109441.target)
	e1:SetOperation(c75109441.operation)
	c:RegisterEffect(e1)
	--confirm
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75109441,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_FLIP)
	e2:SetOperation(c75109441.cfop)
	c:RegisterEffect(e2)
end
function c75109441.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(75109441)==0 end
	c:RegisterFlagEffect(75109441,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c75109441.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c75109441.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
