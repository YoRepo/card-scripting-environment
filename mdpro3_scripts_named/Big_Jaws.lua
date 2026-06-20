--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 大颚鲛  (ID: 51254277)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 3
-- ATK 1800 | DEF 300
--
-- Effect Text:
-- 这张卡攻击的场合，战斗阶段结束时从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--ビッグ・ジョーズ
function c51254277.initial_effect(c)
	--reg
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c51254277.regop)
	c:RegisterEffect(e1)
end
function c51254277.regop(e,tp,eg,ep,ev,re,r,rp)
	--remove
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(51254277,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetTarget(c51254277.rmtg)
	e1:SetOperation(c51254277.rmop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
	e:GetHandler():RegisterEffect(e1)
end
function c51254277.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c51254277.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	end
end
