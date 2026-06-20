--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 游击风筝  (ID: 54629413)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Fiend
-- Level 4
-- ATK 1600 | DEF 200
--
-- Effect Text:
-- 「游击风筝」的效果1回合只能使用1次。
-- ①：这张卡从场上送去墓地的场合发动。给与对方500伤害。
--[[ __CARD_HEADER_END__ ]]

--ゲリラカイト
function c54629413.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54629413,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,54629413)
	e1:SetCondition(c54629413.damcon)
	e1:SetTarget(c54629413.damtg)
	e1:SetOperation(c54629413.damop)
	c:RegisterEffect(e1)
end
function c54629413.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c54629413.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c54629413.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
