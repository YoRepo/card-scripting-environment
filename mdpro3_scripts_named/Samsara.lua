--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 轮回转生  (ID: 44182827)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 作为仪式召唤的祭品的怪兽卡不去墓地，回到持有者的卡组。之后卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--輪廻転生
function c44182827.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c44182827.rmtarget)
	e2:SetValue(LOCATION_DECKSHF)
	c:RegisterEffect(e2)
end
function c44182827.rmtarget(e,c)
	return c:GetReason()==REASON_RELEASE+REASON_RITUAL+REASON_EFFECT+REASON_MATERIAL
end
