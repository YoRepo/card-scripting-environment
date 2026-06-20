--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 召唤师 莱斯贝尔特  (ID: 45103815)
-- Type: Monster / Normal / Pendulum
-- Attribute: WIND
-- Race: Psychic
-- Level 3
-- Pendulum Scales: L2 / R2
-- ATK 800 | DEF 800
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，以场上1只表侧表示怪兽为对象才能发动。那只怪兽的等级上升1星。
-- 【怪兽描述】
-- 非常关心爱护妹妹塞姆贝尔，温和亲切的哥哥莱斯贝尔特。刚过中午的午后他跟妹妹一起读魔术书的时间是每日惯例，见到那俩人和睦的情景让周围人们也自然而然被治愈心灵。
--[[ __CARD_HEADER_END__ ]]

--召喚師ライズベルト
function c45103815.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c45103815.lvtg)
	e2:SetOperation(c45103815.lvop)
	c:RegisterEffect(e2)
end
function c45103815.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c45103815.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c45103815.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45103815.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c45103815.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c45103815.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
