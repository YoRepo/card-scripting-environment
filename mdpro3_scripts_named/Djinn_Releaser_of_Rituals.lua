--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 仪式魔人 解放者  (ID: 8903700)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1200 | DEF 2000
-- Setcode: 109
--
-- Effect Text:
-- ①：仪式召唤进行的场合，可以作为那次仪式召唤需要的等级数值的1只怪兽，把墓地的这张卡除外。
-- ②：从使用这张卡仪式召唤的玩家来看的对方，只要仪式召唤的那只怪兽在怪兽区域表侧表示存在，不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--儀式魔人リリーサー
function c8903700.initial_effect(c)
	--ritual material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_EVENT_PLAYER)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c8903700.condition)
	e2:SetOperation(c8903700.operation)
	c:RegisterEffect(e2)
end
function c8903700.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL and not e:GetHandler():IsPreviousLocation(LOCATION_OVERLAY)
end
function c8903700.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(8903700)==0 then
			--cannot special summon
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(8903700,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetAbsoluteRange(ep,0,1)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(8903700,RESET_EVENT+RESETS_STANDARD,0,1)
		end
		rc=eg:GetNext()
	end
end
