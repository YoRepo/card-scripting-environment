--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 幻蝶刺客 凤蝶  (ID: 79972330)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 106
--
-- Effect Text:
-- 这张卡以外的自己场上的怪兽给与对方基本分战斗伤害时，选择对方场上表侧表示存在的1只怪兽发动。选择的怪兽的攻击力下降那个时候给与的伤害的数值。
--[[ __CARD_HEADER_END__ ]]

--幻蝶の刺客アゲハ
function c79972330.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79972330,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c79972330.atcon)
	e1:SetTarget(c79972330.attg)
	e1:SetOperation(c79972330.atop)
	c:RegisterEffect(e1)
end
function c79972330.atcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	return ep~=tp and rc~=e:GetHandler() and rc:IsControler(tp)
end
function c79972330.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c79972330.atop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-ev)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
